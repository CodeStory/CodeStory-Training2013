package codestory;

import java.io.File;
import java.util.regex.Matcher;

import static java.lang.Integer.parseInt;
import static java.util.regex.Pattern.compile;

class Step implements Comparable<Step> {

    private final Integer order;
    private final String name;

    Step(Integer order, String name) {
        this.order = order;
        this.name = name;
    }

    Step(File file) {
        Matcher orderAndNameExtractor = compile("(\\d+)-(.+)\\.sh").matcher(file.getName());
        if (!orderAndNameExtractor.matches()) {
            throw new IllegalArgumentException();
        }

        this.order = parseInt(orderAndNameExtractor.group(1));
        this.name = orderAndNameExtractor.group(2);
    }

    String name() {
        return name;
    }

    @Override
    public int compareTo(Step otherStep) {
        return order.compareTo(otherStep.order);
    }

    @Override
    public boolean equals(Object otherStep) {
        if (this == otherStep) {
            return true;
        }
        if (otherStep == null || getClass() != otherStep.getClass()) {
            return false;
        }

        Step step = (Step) otherStep;

        return name.equals(step.name) && order.equals(step.order);
    }

    @Override
    public int hashCode() {
        int result = order.hashCode();
        result = 31 * result + name.hashCode();
        return result;
    }
}
