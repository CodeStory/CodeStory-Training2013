package codestory;

import java.io.File;
import java.util.Iterator;
import java.util.SortedSet;
import java.util.TreeSet;

class Steps implements Iterable<Step> {

    private final SortedSet<Step> steps;

    Steps(final File directory) {
        steps = new TreeSet<>();

        if (!directory.exists()) {
            return;
        }

        for (final File stepAsFile : directory.listFiles((dir, name) -> name.endsWith(".sh"))) {
            steps.add(new Step(stepAsFile));
        }
    }

    Steps(final String... steps) {
        this.steps = new TreeSet<>();
        for (Integer i = 0; i < steps.length; i++) {
            this.steps.add(new Step(i, steps[i]));
        }
    }

    @Override
    public Iterator<Step> iterator() {
        return steps.iterator();
    }

}
