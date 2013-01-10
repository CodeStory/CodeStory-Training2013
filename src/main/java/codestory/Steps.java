package codestory;

import java.io.File;
import java.util.Iterator;
import java.util.SortedSet;
import java.util.TreeSet;

class Steps implements Iterable<Step> {

    private final SortedSet<Step> steps;

    Steps(File directory) {
        steps = new TreeSet<>();
        for (final File stepAsFile : directory.listFiles((dir, name) -> name.endsWith(".sh"))) {
            steps.add(new Step(stepAsFile));
        }
    }

    @Override
    public Iterator<Step> iterator() {
        return steps.iterator();
    }

}
