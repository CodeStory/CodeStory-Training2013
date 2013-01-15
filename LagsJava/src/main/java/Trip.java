import java.util.Arrays;

public class Trip {
  private final Flight[] flights;
  private final int[] nextCompat;
  private final int[] cache;

  public Trip(String input) {
    this(FlightsForString.forString(input));
  }

  public Trip(Flight[] flights) {
    Arrays.sort(flights);
    this.flights = flights;
    this.nextCompat = nextCompat(flights);
    this.cache = cache(flights);
  }

  private static int[] cache(Flight[] flights) {
    int[] cache = new int[flights.length];
    Arrays.fill(cache, -1);
    return cache;
  }

  private static int[] nextCompat(Flight[] flights) {
    int[] nextCompat = new int[flights.length];
    Arrays.fill(nextCompat, -1);

    for (int i = 0; i < flights.length; i++) {
      Flight flight = flights[i];

      for (int j = i + 1; j < flights.length; j++) {
        Flight otherFlight = flights[j];

        if (otherFlight.takeOff >= flight.landing) {
          nextCompat[i] = j;
          break;
        }
      }
    }

    return nextCompat;
  }

  public int gain() {
    return gain(0);
  }

  private int gain(int index) {
    if ((-1 == index) || (index >= flights.length)) {
      return 0;
    }

    if (cache[index] != -1) {
      return cache[index];
    }

    int gainWithFlight = flights[index].gain + gain(nextCompat[index]);
    int gainWithoutFlight = gain(index + 1);

    int max = Math.max(gainWithoutFlight, gainWithFlight);
    cache[index] = max;
    return max;
  }
}
