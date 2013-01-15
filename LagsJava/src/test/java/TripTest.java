import com.google.common.base.Charsets;
import com.google.common.io.Files;
import org.junit.Test;

import java.io.File;
import java.io.IOException;

import static org.fest.assertions.Assertions.assertThat;

public class TripTest {
  @Test
  public void should_gain_zero_for_zero_flight() {
    assertThat(new Trip("").gain()).isZero();
  }

  @Test
  public void should_pick_the_only_flight() {
    assertThat(new Trip("AF514 0 5 10").gain()).isEqualTo(10);
    assertThat(new Trip("AF514 0 5 20").gain()).isEqualTo(20);
  }

  @Test
  public void should_pick_best_of_two_flights_happening_at_the_same_time() {
    assertThat(new Trip(
      "AF514 0 5 10\n" +
        "AF666 0 5 20").gain()).isEqualTo(20);
  }

  @Test
  public void should_sum_gain_of_compatible_flights() {
    assertThat(new Trip(
      "AF514 0 1 10\n" +
        "AF666 2 3 20").gain()).isEqualTo(30);
  }

  @Test
  public void should_pick_best_of_two_incompatible_flights() {
    assertThat(new Trip(
      "AF514 0 5 10\n" +
        "AF666 1 5 20").gain()).isEqualTo(20);
  }

  @Test
  public void should_prefer_single_flight_with_higher_gain_over_combination_of_two() {
    assertThat(new Trip(
      "AF51 0 2 10\n" +
        "AF52 2 1 20\n" +
        "AF53 0 3 40").gain()).isEqualTo(40);
  }

  @Test
  public void should_prefer_best_combination_of_two_flights() {
    assertThat(new Trip(
      "AF51 0 2 10\n" +
        "AF52 2 1 20\n" +
        "AF52 0 2 20\n" +
        "AF53 2 1 40").gain()).isEqualTo(60);
  }

  @Test
  public void should_() {
    assertThat(new Trip(
      "AF50 0 1 10\n" +
        "AF51 1 1 10\n" +
        "AF52 2 1 20\n" +
        "AF52 1 1 20\n" +
        "AF53 2 1 40").gain()).isEqualTo(70);
  }

  @Test
  public void should_read_trip3() throws IOException {
    assertThat(new Trip(Files.toString(new File("trip3.txt"), Charsets.UTF_8)).gain()).isEqualTo(80);
  }

  @Test
  public void should_read_trip10() throws IOException {
    assertThat(new Trip(Files.toString(new File("trip10.txt"), Charsets.UTF_8)).gain()).isEqualTo(202);
  }

  @Test
  public void should_read_trip30() throws IOException {
    assertThat(new Trip(Files.toString(new File("trip30.txt"), Charsets.UTF_8)).gain()).isEqualTo(281);
  }
}
