package codestory;

import java.io.File;
import java.util.Map;

import static java.io.File.separatorChar;
import static java.lang.String.format;
import static java.lang.System.exit;
import static java.util.Collections.unmodifiableMap;

public class GraphGenerator {

    public Map<String, Integer> getScores(final File directory) {
        final Steps steps = new Steps(new File(directory, "scripts" + separatorChar + "steps"));
        final Logins logins = new Logins(new File(directory, "logins"));

        return unmodifiableMap(logins.getScores(steps));
    }

    public static void main(String... args) {
        if (args.length != 1) {
            System.err.println("usage: java " + GraphGenerator.class.getCanonicalName() + " <directory>");
            exit(1);
        }

        for (final Map.Entry<String, Integer> score : new GraphGenerator().getScores(new File(args[0])).entrySet()) {
            System.out.println(format("%3d %s", score.getValue(), score.getKey()));
        }
    }

}
