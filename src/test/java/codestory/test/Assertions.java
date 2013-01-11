package codestory.test;

import org.fest.assertions.SortedMapAssert;

import java.util.SortedMap;

public class Assertions {

    public static SortedMapAssert assertThat(SortedMap<?, ?> actual) {
        return new SortedMapAssert(actual);
    }

}
