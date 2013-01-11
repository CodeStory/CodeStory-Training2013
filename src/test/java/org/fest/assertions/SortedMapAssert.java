package org.fest.assertions;

import java.util.Iterator;
import java.util.Map;
import java.util.SortedMap;

public class SortedMapAssert extends MapAssert {

    public SortedMapAssert(final SortedMap<?, ?> actual) {
        super(actual);
    }

    public SortedMapAssert isEqualToSorted(final Entry... expectedEntries) {
        isNotNull();
        hasSize(expectedEntries.length);
        final Iterator<? extends Map.Entry<?, ?>> actualEntries = actual.entrySet().iterator();
        for (final Entry expectedEntry : expectedEntries) {
            final Map.Entry<?, ?> actualEntry = actualEntries.next();
            if (!actualEntry.getKey().equals(expectedEntry.key) || !actualEntry.getValue().equals(expectedEntry.value)) {
                fail(actualEntry + " != " + expectedEntry);
                return this;
            }
        }
        return this;
    }

}
