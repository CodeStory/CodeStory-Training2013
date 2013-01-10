package codestory;

import java.io.File;
import java.util.Map;

import static java.io.File.separatorChar;
import static java.util.Collections.unmodifiableMap;

public class GraphGenerator {

    public Map<String, Integer> getScores(final File directory) {
        final Steps steps = new Steps(new File(directory, "scripts" + separatorChar + "steps"));
        final Logins logins = new Logins(new File(directory, "logins"));

        return unmodifiableMap(logins.getScores(steps));
    }

}
