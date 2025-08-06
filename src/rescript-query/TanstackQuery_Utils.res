// let retry: TanstackQuery_Types.retryParam<'error> => TanstackQuery_Types.retryValue<
//   'error,
// > = value =>
//   switch value {
//   | #bool(value) => Obj.magic(value)
//   | #number(value) => Obj.magic(value)
//   | #fn(value) => Obj.magic(value)
//   }

// let retryDelay: TanstackQuery_Types.retryDelayParam<'error> => TanstackQuery_Types.retryDelayValue<
//   'error,
// > = value =>
//   switch value {
//   | #number(value) => Obj.magic(value)
//   | #fn(value) => Obj.magic(value)
//   }

// let time: TanstackQuery_Types.time => TanstackQuery_Types.timeValue = value =>
//   switch value {
//   | #number(value) => Obj.magic(value)
//   | #infinity => Obj.magic(infinity)
//   }

// let refetchInterval = value =>
//   switch value {
//   | #bool(value) => Obj.magic(value)
//   | #number(value) => Obj.magic(value)
//   }

// let boolOrAlways = value =>
//   switch value {
//   | #bool(value) => Obj.magic(value)
//   | #always => Obj.magic(#always)
//   }

// let notifyOnChangeProps = value =>
//   switch value {
//   | #array(value) => Obj.magic(value)
//   | #tracked => Obj.magic(#tracked)
//   }

// let setQueryData: TanstackQuery_Types.queryDataKeyOrFilter<
//   'queryKey,
// > => TanstackQuery_Types.queryDataKeyOrFilter<'queryKey> = value =>
//   switch value {
//   | #keys(value) => Obj.magic(value)
//   | #filters(value) => Obj.magic(value)
//   }

// let placeholderData: TanstackQuery_Types.placeholderData<
//   'queryData,
//   'queryResult,
// > => TanstackQuery_Types.placeholderDataValue = value =>
//   switch value {
//   | #data(data) => Obj.magic(data)
//   | #function(value) => Obj.magic(value)
//   }

// let refetchOnMount = boolOrAlways
// let refetchOnWindowFocus = boolOrAlways
// let refetchOnReconnect = boolOrAlways
