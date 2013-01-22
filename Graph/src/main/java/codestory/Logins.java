package codestory;

import java.io.File;
import java.util.*;

import static java.util.Collections.addAll;

class Logins implements Iterable<Login> {

    private final Set<Login> logins;

    Logins() {
        logins = new HashSet<>();
    }

    Logins update(Date date, File directory, Steps steps) {
        if (!directory.exists()) {
            return this;
        }

        Map<Login, Set<String>> stepsBylogins = new HashMap<>();

        for (File loginAsFile : directory.listFiles(File::isDirectory)) {
            logins.add(new Login(loginAsFile.getName()));
            stepsBylogins.put(login(loginAsFile.getName()), asSet(loginAsFile.list()));
        }

        for (Map.Entry<Login, Set<String>> stepsByLogin : stepsBylogins.entrySet()) {
            Integer score = 0;
            for (Step step : steps) {
                if (stepsByLogin.getValue().contains(step.name())) {
                    score++;
                }
            }
            stepsByLogin.getKey().setScore(date, score);
        }

        return this;
    }

    Logins keepOnlyExistingLogins(File directory) {
        if (!directory.exists()) {
            return this;
        }

        System.err.println("logins.size " + logins.size());

        Set<Login> existingLogins = new HashSet<>();
        for (File loginAsFile : directory.listFiles(File::isDirectory)) {
            if (contains(loginAsFile.getName())) {
                existingLogins.add(login(loginAsFile.getName()));
            }
        }
        logins.clear();
        logins.addAll(existingLogins);

        System.err.println("logins.size " + logins.size());

        return this;
    }

    Login login(String loginName) {
        for (Login login : logins) {
            if (login.name().equals(loginName)) {
                return login;
            }
        }
        throw new NoSuchElementException();
    }

    private boolean contains(String loginName) {
        for (Login login : logins) {
            if (login.name().equals(loginName)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public Iterator<Login> iterator() {
        return logins.iterator();
    }

    private static Set<String> asSet(String... strings) {
        HashSet<String> set = new HashSet<>(strings.length);
        addAll(set, strings);
        return set;
    }
}
