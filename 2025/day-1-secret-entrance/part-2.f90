program part2
        implicit none

        integer :: position = 50
        integer :: old_position
        integer :: count = 0

        character(len=256) :: line
        character :: direction
        integer :: distance
        integer :: ios

        integer :: unit
        open(newunit=unit, file='/dev/stdin', status='old', action='read')

        do
                read(unit, '(A)', iostat=ios) line
                if (ios /= 0) exit

                write(*, '(I0)', advance='no') position

                direction = line(1:1)
                read(line(2:), *) distance

                write(*, '(A,A,I0)', advance='no') " + ", direction, distance

                if (direction == 'L') then
                        distance = -distance
                end if

                write(*, '(A,I0,A)', advance='no') " (", distance, ")"

                old_position = position
                position = position + distance

                write(*, '(A,I0)', advance='no') " -> ", position

                if (position == 0 .AND. old_position /= 0) then
                        count = count + 1
                else if (position > 99) then
                        count = count + position / 100
                        position = mod(position, 100)
                else if (position < 0) then
                        count = count + abs(position) / 100 + 1
                        if (old_position == 0) count = count - 1
                        position = 100 + mod(position, 100)
                        if (position == 100) position = 0
                end if

                write(*, '(A,I0,A,I0,A)') " = ", position, " [", count, "]"
        end do

        close(unit)

        write(*, '(I0)') count
end program part2
