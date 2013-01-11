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
import static java.util.Collections.unmodifiableMap;

public class GraphGenerator {

    public Map<String, Integer> getScores(final File directory) {
        final Map<String, Integer> scores = new HashMap<>();

        final Steps steps = new Steps(new File(directory, "scripts" + separatorChar + "steps"));
        final Logins logins = new Logins().update(new Date(), new File(directory, "logins"), steps);

        for (Login login : logins) {
            scores.put(login.name(), login.score());
        }

        return unmodifiableMap(scores);
    }

    public Set<String> commits(final File gitDir) {
        final LinkedHashSet<String> commits = new LinkedHashSet<>();
        final Repository repository;
        try {
            repository = new RepositoryBuilder().setGitDir(gitDir).findGitDir().setMustExist(true).build();
            final Git git = new Git(repository);
            for (RevCommit revCommit : git.log().call()) {
                commits.add(revCommit.getId().name());
            }
        } catch (IOException | GitAPIException e) {
            e.printStackTrace();
        }
        return commits;
    }

    public static void main(String... args) {
        if (args.length != 1) {
            System.err.println("usage: java " + GraphGenerator.class.getCanonicalName() + " <directory>");
            exit(1);
        }

        final File directory = new File(args[0]);
        final GraphGenerator graphGenerator = new GraphGenerator();

        System.out.println("cd " + directory.getAbsolutePath());
        for (String commit : graphGenerator.commits(new File(args[0] + separator + ".git"))) {
            System.out.println("git reset --hard " + commit);
            for (final Map.Entry<String, Integer> scoreByLogins : graphGenerator.getScores(directory).entrySet()) {
                System.out.println(format("%3d %s", scoreByLogins.getValue(), scoreByLogins.getKey()));
            }
            System.out.println();
        }
    }

}
