package codestory;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;

class Logins {

    private final Map<String, List<String>> stepsBylogins;

    Logins(final File directory) {
        stepsBylogins = new HashMap<>();
        for (final File loginAsFile : directory.listFiles(pathname -> pathname.isDirectory())) {
            stepsBylogins.put(loginAsFile.getName(), asList(loginAsFile.list()));
        }
    }

    Map<String, Integer> getScores(final Steps steps) {
        final Map<String, Integer> scores = new HashMap<>();

        for (final Map.Entry<String, List<String>> stepsByLogin : stepsBylogins.entrySet()) {
            Integer score = 0;
            for (final Step step : steps) {
                if (stepsByLogin.getValue().contains(step.name())) {
                    score++;
                }
            }
            scores.put(stepsByLogin.getKey(), score);
        }

        return scores;
    }

}
