// docker run -it --mount type=bind,source="$(pwd)",target=/app amazoncorretto:8 /bin/bash
// javac Part1.java && java Part1

import java.util.*;

public class Part2 {
  public static final Integer ARock = 1;
  public static final Integer APaper = 2;
  public static final Integer AScissor = 3;

  public static final Integer RLose = 0;
  public static final Integer RDraw = 3;
  public static final Integer RWin = 6;

  static Map<String, Integer> values = new HashMap<String, Integer>() {{
    put("A X", AScissor + RLose);
    put("A Y", ARock + RDraw);
    put("A Z", APaper + RWin);

    put("B X", ARock + RLose);
    put("B Y", APaper + RDraw);
    put("B Z", AScissor + RWin);

    put("C X", APaper + RLose);
    put("C Y", AScissor + RDraw);
    put("C Z", ARock + RWin);
  }};

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);

    Integer total = 0;
    while (sc.hasNextLine()) {
      total += values.get(sc.nextLine());
    }

    System.out.println(total);
  }
}
