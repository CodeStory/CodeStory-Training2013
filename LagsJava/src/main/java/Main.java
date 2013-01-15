public class Main {
  public static void main(String[] args) throws Exception {
    String json = args[0];

    Trip trip = new Trip(FlightsForJson.forJson(json));
    int gain = trip.gain();

    System.out.println(gain);
  }
}
