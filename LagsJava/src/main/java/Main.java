import com.google.common.base.Charsets;

import java.io.InputStreamReader;

public class Main {
  public static void main(String[] args) throws Exception {
    Trip trip = new Trip(FlightsForJson.forJson(new InputStreamReader(System.in, Charsets.UTF_8)));
    int gain = trip.gain();

    System.out.println(gain);
  }
}
