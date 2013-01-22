package codestory;

import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.errors.GitAPIException;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.lib.RepositoryBuilder;
import org.eclipse.jgit.revwalk.RevCommit;

import java.io.File;
import java.io.IOException;
import java.util.*;

import static java.io.File.separator;
import static java.io.File.separatorChar;
import static java.lang.String.format;
import static java.lang.System.exit;

public class GraphGenerator {

    private final Logins logins = new Logins();

    public Logins logins() {
        return logins;
    }

    public GraphGenerator update(final Date date, final File directory) {
        final Steps steps = new Steps(new File(directory, "scripts" + separatorChar + "steps"));
        logins.update(date, new File(directory, "logins"), steps);
        return this;
    }

    public SortedMap<Date, String> commitIdsByDate(final File gitDir) {
        final SortedMap<Date, String> commits = new TreeMap<>();
        final Repository repository;
        try {
            repository = new RepositoryBuilder().setGitDir(gitDir).findGitDir().setMustExist(true).build();
            final Git git = new Git(repository);
            for (RevCommit revCommit : git.log().call()) {
                commits.put(new Date((long) revCommit.getCommitTime() * 1000), revCommit.getId().name());
            }
        } catch (IOException | GitAPIException e) {
            e.printStackTrace();
        }
        return commits;
    }

    public static void main(final String... args) throws IOException, InterruptedException {
        if (args.length != 1) {
            System.err.println("usage: java " + GraphGenerator.class.getCanonicalName() + " <directory>");
            exit(1);
        }

        final File directory = new File(args[0]);
        final ProcessBuilder processBuilder = new ProcessBuilder().directory(directory.getAbsoluteFile());
        final GraphGenerator graphGenerator = new GraphGenerator();

        resetGitTo(processBuilder, "origin/master");

        for (final Map.Entry<Date, String> commitByDate :
                graphGenerator.commitIdsByDate(new File(args[0] + separator + ".git")).entrySet()) {
            resetGitTo(processBuilder, commitByDate.getValue());

            graphGenerator.update(commitByDate.getKey(), directory);
        }

        final StringBuilder json = new StringBuilder();
        for (final Login login : graphGenerator.logins) {
            generateGraphEntry(json, login);
        }

        if (json.length() > 2) {
            json.deleteCharAt(json.length() - 2);
        }

        System.out.println(json.toString());
    }

    private static void resetGitTo(final ProcessBuilder processBuilder, final String ref)
            throws InterruptedException, IOException {
        System.out.println("git reset --hard " + ref);
        final int exitValue = processBuilder.command("git", "reset", "--hard", ref).start().waitFor();
        if (exitValue != 0) {
            System.err.println("error");
            System.exit(exitValue);
        }
    }

    private static StringBuilder generateGraphEntry(final StringBuilder json, final Login login) {
        Integer previousScore = -1;

        json.append("{\n");
        json.append(format("    name: '%s',\n", login.name()));
        json.append("    data: [\n");

        for (final Map.Entry<Date, Integer> score : login.scores().entrySet()) {
            if (previousScore.equals(score.getValue())) {
                continue;
            }
            final Calendar calendar = Calendar.getInstance();
            calendar.setTime(score.getKey());
            json.append(format("        [Date.UTC(%tY, %d, %1$te, %<tk, %<tM, %<tS), %d],\n",
                    calendar, calendar.get(Calendar.MONTH), score.getValue()));
            previousScore = score.getValue();
        }

        if (!previousScore.equals(-1)) {
            json.deleteCharAt(json.length() - 2);
        }

        json.append("    ]\n");
        json.append("},\n");

        return json;
    }

}
