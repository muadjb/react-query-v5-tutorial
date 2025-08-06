let use = (value, delay) => {
  let (debouncedValue, setDebouncedValue) = React.useState(_ => value)

  React.useEffect(() => {
    let timer = setTimeout(() => {
      setDebouncedValue(_ => value)
    }, delay)

    Some(_ => clearTimeout(timer))
  }, (value, delay))

  debouncedValue
}
