package codestory;

import org.junit.Test;

import java.io.File;
import java.net.URISyntaxException;
import java.util.Map;
import java.util.SortedMap;
import java.util.SortedSet;

import static codestory.test.Assertions.assertThat;
import static java.util.Arrays.asList;
import static org.fest.assertions.MapAssert.entry;

public class GraphGeneratorTest {

    @Test
    public void should_get_scores_sorted_by_descending_score() throws Exception {
        final SortedMap<Integer, SortedSet<String>> scores = new GraphGenerator().getScores(directory("tree"));

        assertThat(scores).isEqualToSorted(entry(2, asList("login1")), entry(0, asList("login2")));
    }

    @Test
    public void should_get_same_scores() throws Exception {
        final SortedMap<Integer, SortedSet<String>> scores = new GraphGenerator().getScores(directory("tree-with-same-score"));

        for (Map.Entry<Integer, SortedSet<String>> loginNamesByScores : scores.entrySet()) {
            StringBuilder loginNames = new StringBuilder();
            for (String loginName : loginNamesByScores.getValue()) {
                if (loginNames.length() > 0) {
                    loginNames.append(", ");
                }
                loginNames.append(loginName);
            }
        }

        assertThat(scores).isEqualToSorted(entry(1, asList("login1", "login2")));
    }

    private static File directory(final String directoryName) throws URISyntaxException {
        return new File(GraphGeneratorTest.class.getResource("/" + directoryName).toURI());
    }

}
