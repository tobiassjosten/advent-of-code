process.stdin.on('data', data => {
  const addition = (carry, value) => +value + carry

  const reduction = (carry, values) => {
    const sum = values.split('\n').reduce(addition, 0)

    if (sum > carry[0]) {
      carry = [sum, carry[0], carry[1]]
    } else if (sum > carry[1]) {
      carry = [carry[0], sum, carry[1]]
    } else if (sum > carry[2]) {
      carry = [carry[0], carry[1], sum]
    }

    return carry
  }

  const sums = data.toString().split('\n\n').reduce(reduction, [0, 0, 0])

  const max = sums.reduce(addition, 0)
  console.log(max)

  process.exit()
});
