import java.util.*;

public class Part1 {
  static Map<String, Integer> values = new HashMap<String, Integer>() {{
    put("X", 1);
    put("Y", 2);
    put("Z", 3);
  }};

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);

    Integer total = 0;
    while (sc.hasNextLine()) {
      Integer result = calculate(sc.nextLine().split(" "));
      total += result;
    }

    System.out.println(total);
  }

  static Integer calculate(String[] parts) {
    String action = parts[1];

    Integer value = values.get(action);

    switch (parts[0] + action) {
      case "AZ":
      case "BX":
      case "CY":
        return 0 + value;

      case "AX":
      case "BY":
      case "CZ":
        return 3 + value;

      case "AY":
      case "BZ":
      case "CX":
        return 6 + value;
    }

    return 0;
  }
}
