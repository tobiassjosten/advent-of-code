package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
	count := 0;

	buf, _ := os.read_entire_file_from_handle(os.stdin);
	input := strings.trim_space(string(buf));

	for range in strings.split(input, ",") {
		ends := strings.split(range, "-");
		if len(ends) != 2 {
			fmt.println("Invalid range:", range);
			continue;
		}

		from, fromOK := strconv.parse_int(ends[0]);
		if !fromOK {
			fmt.println("Invalid start in range:", range);
			continue;
		}

		to, toOK := strconv.parse_int(ends[1]);
		if !toOK {
			fmt.println("Invalid end in range:", range);
			continue;
		}

		for i in from..=to {
			buf: [128]byte;
			s := strconv.write_int(buf[:], i64(i), 10);

			if len(s) % 2 != 0 {
				   continue;
			}

			if s[:len(s)/2] == s[len(s)/2:] {
				count += i;
			}
		}
	}

	fmt.println(count);
}
