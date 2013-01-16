import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.Reader;
import java.util.List;

public class FlightsForJson {
  public static Flight[] forJson(Reader json) {

    TypeToken<List<FlightTemp>> typeToken = new TypeToken<List<FlightTemp>>() {
    };

    List<FlightTemp> flightTemps = new Gson().fromJson(json, typeToken.getType());

    Flight[] flights = new Flight[flightTemps.size()];

    int index = 0;
    for (FlightTemp flight : flightTemps) {
      int takeOff = flight.DEPART;
      int landing = takeOff + flight.DUREE;
      int gain = flight.PRIX;

      flights[index++] = new Flight(takeOff, landing, gain);
    }

    return flights;
  }

  static class FlightTemp {
    int DEPART;
    int DUREE;
    int PRIX;
  }
}
