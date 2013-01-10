package codestory;

import org.junit.Test;

import java.io.File;
import java.util.Map;

import static org.fest.assertions.Assertions.assertThat;
import static org.fest.assertions.MapAssert.entry;

public class GraphGeneratorTest {

    @Test
    public void should_generate_graph() throws Exception {
        final Map<String, Integer> scores = new GraphGenerator().getScores(new File(getClass().getResource("/tree").toURI()));

        assertThat(scores)
                .hasSize(2)
                .includes(entry("login1", 2), entry("login2", 0));
    }

}
