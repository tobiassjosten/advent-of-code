process.stdin.on('data', data => {
  const addition = (carry, value) => +value + carry

  const reduction = (carry, values) => Math.max(
    carry, values.split('\n').reduce(addition, 0)
  )

  const max = data.toString().split('\n\n').reduce(reduction, 0)
  console.log(max)

  process.exit()
});
