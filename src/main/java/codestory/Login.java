package codestory;

import java.util.Date;
import java.util.SortedMap;
import java.util.TreeMap;

class Login {

    private final String name;
    private final SortedMap<Date, Integer> scores;

    Login(final String name) {
        this.name = name;
        this.scores = new TreeMap<>();
    }

    String name() {
        return name;
    }

    Integer score() {
        if (scores.isEmpty()) {
            return 0;
        }

        return scores.get(scores.lastKey());
    }

    Login setScore(final Date date, final Integer score) {
        if (scores.containsKey(date)) {
            scores.put(date, scores.get(date) + score);
        } else {
            scores.put(date, score);
        }
        return this;
    }
}
