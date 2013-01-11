package codestory;

import org.junit.Test;

import java.io.File;
import java.util.SortedMap;

import static codestory.test.Assertions.assertThat;
import static org.fest.assertions.MapAssert.entry;

public class GraphGeneratorTest {

    @Test
    public void should_get_scores_sorted_by_descending_score() throws Exception {
        final SortedMap<String, Integer> scores =
                new GraphGenerator().getScores(new File(getClass().getResource("/tree").toURI()));

        assertThat(scores).isEqualToSorted(entry("login1", 2), entry("login2", 0));
    }

}
