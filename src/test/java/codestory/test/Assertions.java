package codestory.test;

import org.fest.assertions.SortedMapAssert;

import java.util.SortedMap;
import java.util.SortedSet;

public class Assertions {

    public static SortedMapAssert assertThat(final SortedMap<?, ? extends SortedSet<?>> actual) {
        return new SortedMapAssert(actual);
    }

}
