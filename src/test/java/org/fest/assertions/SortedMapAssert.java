package org.fest.assertions;

import java.util.*;

import static org.fest.assertions.Assertions.assertThat;

public class SortedMapAssert extends MapAssert {

    private final SortedMap<?, ? extends SortedSet<?>> myActual;

    public SortedMapAssert(final SortedMap<?, ? extends SortedSet<?>> actual) {
        super(actual);
        this.myActual = actual;
    }

    public SortedMapAssert isEqualToSorted(final Entry... expectedEntries) {
        isNotNull();
        hasSize(expectedEntries.length);
        final Iterator<? extends Map.Entry<?, ? extends SortedSet<?>>> actualEntries = myActual.entrySet().iterator();
        for (final Entry expectedEntry : expectedEntries) {
            final Map.Entry<?, ?> actualEntry = actualEntries.next();
            if (!actualEntry.getKey().equals(expectedEntry.key)) {
                fail(actualEntry + " != " + expectedEntry);
                return this;
            }
            final List expectedEntryValues = (List) expectedEntry.value;
            assertThat((SortedSet) actualEntry.getValue()).containsOnly(expectedEntryValues.toArray());
        }
        return this;
    }

}
