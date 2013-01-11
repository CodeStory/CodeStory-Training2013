package codestory;

import java.io.File;
import java.util.*;

import static java.util.Arrays.asList;

class Logins implements Iterable<Login> {

    private final Map<Login, List<String>> stepsBylogins;

    private final Set<Login> logins;

    Logins() {
        stepsBylogins = new HashMap<>();
        logins = new HashSet<>();
    }

    Logins update(final Date date, final File directory, final Steps steps) {
        for (final File loginAsFile : directory.listFiles(pathname -> pathname.isDirectory())) {
            logins.add(new Login(loginAsFile.getName()));
            stepsBylogins.put(login(loginAsFile.getName()), asList(loginAsFile.list()));
        }

        for (final Map.Entry<Login, List<String>> stepsByLogin : stepsBylogins.entrySet()) {
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

}
