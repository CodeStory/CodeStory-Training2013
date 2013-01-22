package codestory;

import java.util.Date;
import java.util.SortedMap;
import java.util.TreeMap;

import static java.util.Collections.unmodifiableSortedMap;

class Login {

    private final String name;
    private final SortedMap<Date, Integer> scores;

    Login(String name) {
        if (name == null) {
            throw new IllegalArgumentException();
        }
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

    SortedMap<Date, Integer> scores() {
        return unmodifiableSortedMap(scores);
    }

    Login setScore(Date date, Integer score) {
        scores.put(date, score);
        return this;
    }

    @Override
    public boolean equals(Object login) {
        return this == login || login instanceof Login && name.equals(((Login) login).name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
