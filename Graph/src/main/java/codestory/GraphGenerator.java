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

    public GraphGenerator update(Date date, File directory) {
        Steps steps = new Steps(new File(directory, "scripts" + separatorChar + "steps"));
        logins.update(date, new File(directory, "logins"), steps);
        return this;
    }

    private GraphGenerator keepOnlyExistingLogins(File directory) {
        logins.keepOnlyExistingLogins(new File(directory, "logins"));
        return this;
    }

    public SortedMap<Date, String> commitIdsByDate(File gitDir) {
        SortedMap<Date, String> commits = new TreeMap<>();
        Repository repository;
        try {
            repository = new RepositoryBuilder().setGitDir(gitDir).findGitDir().setMustExist(true).build();
            Git git = new Git(repository);
            for (RevCommit revCommit : git.log().call()) {
                commits.put(new Date((long) revCommit.getCommitTime() * 1000), revCommit.getId().name());
            }
        } catch (IOException | GitAPIException e) {
            e.printStackTrace();
        }
        return commits;
    }

    public static void main(String... args) throws IOException, InterruptedException {
        if (args.length != 1) {
            System.err.println("usage: java " + GraphGenerator.class.getCanonicalName() +
                    " <directory> > scores-timeseries.json");
            exit(1);
        }

        System.out.println(generateSeries(args[0]));
    }

    private static void resetGitTo(ProcessBuilder processBuilder, String ref)
            throws InterruptedException, IOException {
        int exitValue = processBuilder.command("git", "reset", "--hard", ref).start().waitFor();
        if (exitValue != 0) {
            System.err.println("error");
            System.exit(exitValue);
        }
    }

    private static String generateSeries(String directoryName) throws InterruptedException, IOException {
        File directory = new File(directoryName);
        ProcessBuilder processBuilder = new ProcessBuilder().directory(directory.getAbsoluteFile());
        GraphGenerator graphGenerator = new GraphGenerator();

        resetGitTo(processBuilder, "origin/master");

        for (Map.Entry<Date, String> commitByDate :
                graphGenerator.commitIdsByDate(new File(directoryName + separator + ".git")).entrySet()) {
            resetGitTo(processBuilder, commitByDate.getValue());

            graphGenerator.update(commitByDate.getKey(), directory);
        }
        graphGenerator.keepOnlyExistingLogins(directory);

        StringBuilder json = new StringBuilder();
        json.append("[\n");

        for (Login login : graphGenerator.logins) {
            generateSerie(json, login);
        }

        if (json.length() > 2) {
            json.deleteCharAt(json.length() - 2);
        }

        json.append("]\n");

        return json.toString();
    }

    private static StringBuilder generateSerie(StringBuilder json, Login login) {
        Integer previousScore = -1;

        json.append("    {\n");
        json.append(format("        \"name\": \"%s\",\n", login.name().replaceAll("\"", "\\\"")));
        json.append("        \"data\": [\n");

        for (Map.Entry<Date, Integer> score : login.scores().entrySet()) {
            if (previousScore.equals(score.getValue())) {
                continue;
            }
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(score.getKey());
            json.append(format("            [%tQ, %d],\n", calendar, score.getValue()));
            previousScore = score.getValue();
        }

        if (!previousScore.equals(-1)) {
            json.deleteCharAt(json.length() - 2);
        }

        json.append("        ]\n");
        json.append("    },\n");

        return json;
    }

}
