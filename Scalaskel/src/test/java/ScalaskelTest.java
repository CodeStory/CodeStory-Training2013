import com.google.common.primitives.Ints;
import org.junit.Test;

import java.util.List;

import static org.fest.assertions.Assertions.assertThat;

public class ScalaskelTest {
  Scalaskel scalaskel = new Scalaskel();

  @Test
  public void should_change_for_1_cent() {
    List<List<Integer>> combinations = toCombinations(1, scalaskel.json(1));

    assertThat(combinations).containsOnly(
      coins(1)
    );
  }

  @Test
  public void should_change_for_2_cent2() {
    List<List<Integer>> combinations = toCombinations(2, scalaskel.json(2));

    assertThat(combinations).containsOnly(
      coins(1, 1)
    );
  }

  @Test
  public void should_change_for_7_cents() {
    List<List<Integer>> combinations = toCombinations(7, scalaskel.json(7));

    assertThat(combinations).containsOnly(
      coins(7),
      coins(1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_8_cents() {
    List<List<Integer>> combinations = toCombinations(8, scalaskel.json(8));

    assertThat(combinations).containsOnly(
      coins(7, 1),
      coins(1, 1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_11_cents() {
    List<List<Integer>> combinations = toCombinations(11, scalaskel.json(11));

    assertThat(combinations).containsOnly(
      coins(11),
      coins(7, 1, 1, 1, 1),
      coins(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_19_cents() {
    List<List<Integer>> combinations = toCombinations(19, scalaskel.json(19));

    assertThat(combinations).containsOnly(
      coins(17, 1, 1),
      coins(11, 7, 1),
      coins(11, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 7, 1, 1, 1, 1, 1),
      coins(7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_21_cents() {
    List<List<Integer>> combinations = toCombinations(21, scalaskel.json(21));

    assertThat(combinations).containsOnly(
      coins(17, 1, 1, 1, 1),
      coins(11, 7, 1, 1, 1),
      coins(11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 7, 7),
      coins(7, 7, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_28_cents() {
    List<List<Integer>> combinations = toCombinations(28, scalaskel.json(28));

    assertThat(combinations).containsOnly(
      coins(17, 11),
      coins(17, 7, 1, 1, 1, 1),
      coins(17, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(11, 11, 1, 1, 1, 1, 1, 1),
      coins(11, 7, 7, 1, 1, 1),
      coins(11, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 7, 7, 7),
      coins(7, 7, 7, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
      coins(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    );
  }

  @Test
  public void should_change_for_42_cents() {
    List<List<Integer>> combinations = toCombinations(42, scalaskel.json(42));

    assertThat(combinations).isNotEmpty();
  }

  @Test
  public void should_change_for_97_cents() {
    List<List<Integer>> combinations = toCombinations(97, scalaskel.json(97));

    assertThat(combinations).isNotEmpty();
  }

  static List<Integer> coins(int... coins) {
    return Ints.asList(coins);
  }

  static List<List<Integer>> toCombinations(int cents, String json) {
    return Scalaskel.toCombinations(json);
  }
}
