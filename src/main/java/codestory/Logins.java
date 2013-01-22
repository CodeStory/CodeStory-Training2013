package codestory;

import java.io.File;
import java.util.*;

import static java.util.Collections.addAll;

class Logins implements Iterable<Login> {

    private final Set<Login> logins;

    Logins() {
        logins = new HashSet<>();
    }

    Logins update(final Date date, final File directory, final Steps steps) {
        if (!directory.exists()) {
            return this;
        }

        final Map<Login, Set<String>> stepsBylogins = new HashMap<>();

        for (final File loginAsFile : directory.listFiles(File::isDirectory)) {
            logins.add(new Login(loginAsFile.getName()));
            stepsBylogins.put(login(loginAsFile.getName()), asSet(loginAsFile.list()));
        }

        for (final Map.Entry<Login, Set<String>> stepsByLogin : stepsBylogins.entrySet()) {
            Integer score = 0;
            for (final Step step : steps) {
                if (stepsByLogin.getValue().contains(step.name())) {
                    score++;
                }
            }
            stepsByLogin.getKey().setScore(date, score);
        }

        return this;
    }

    Login login(final String loginName) {
        for (final Login login : logins) {
            if (login.name().equals(loginName)) {
                return login;
            }
        }
        throw new NoSuchElementException();
    }

    @Override
    public Iterator<Login> iterator() {
        return logins.iterator();
    }

    private static Set<String> asSet(String... strings) {
        final HashSet<String> set = new HashSet<>(strings.length);
        addAll(set, strings);
        return set;
    }

}
