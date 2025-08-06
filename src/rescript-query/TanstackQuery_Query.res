// type queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
//   queryKey?: array<'queryKey>,
//   queryFn?: TanstackQuery_Types.queryFunctionContext<array<'queryKey>, 'pageParam> => Js.Promise.t<
//     'queryData,
//   >,
//   enabled?: bool,
//   retry?: TanstackQuery_Types.retryValue<'queryError>,
//   retryOnMount?: bool,
//   retryDelay?: TanstackQuery_Types.retryDelayValue<'queryError>,
//   staleTime?: TanstackQuery_Types.timeValue,
//   queryKeyHashFn?: array<'queryKey> => string,
//   refetchInterval?: TanstackQuery_Types.refetchIntervalValue,
//   refetchIntervalInBackground?: bool,
//   refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
//   refetchOnWindowFocus?: TanstackQuery_Types.boolOrAlwaysValue,
//   refetchOnReconnect?: TanstackQuery_Types.boolOrAlwaysValue,
//   notifyOnChangeProps?: TanstackQuery_Types.notifyOnChangePropsValue,
//   notifyOnChangePropsExclusions?: array<string>,
//   onSuccess?: 'queryData => unit,
//   onError?: 'queryError => unit,
//   onSettled?: ('queryData, 'queryError) => unit,
//   select?: 'queryData => 'queryData,
//   suspense?: bool,
//   keepPreviousData?: bool,
//   structuralSharing?: bool,
//   useErrorBoundary?: bool,
//   initialData?: 'queryData => 'queryData,
//   initialDataUpdatedAt?: unit => int,
//   placeholderData?: unit => 'queryData,
// }

// type rec queryResult<'queryError, 'queryData> = {
//   status: TanstackQuery_Types.queryStatus,
//   isIdle: bool,
//   isError: bool,
//   isFetched: bool,
//   isFetchedAfterMount: bool,
//   isFetching: bool,
//   isLoading: bool,
//   isLoadingError: bool,
//   isPlaceholderData: bool,
//   isPreviousData: bool,
//   isRefetchError: bool,
//   isStale: bool,
//   isSuccess: bool,
//   data: option<'queryData>,
//   dataUpdatedAt: int,
//   error: Js.Nullable.t<'queryError>,
//   errorUpdatedAt: int,
//   failureCount: int,
//   refetch: TanstackQuery_Types.refetchOptions => Js.Promise.t<queryResult<'queryError, 'queryData>>,
//   remove: unit => unit,
// }

// @module("@tanstack/react-query")
// external useQuery: queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> => queryResult<
//   'queryError,
//   'queryData,
// > = "useQuery"

// type queriesOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
//   queries: array<queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam>>,
// }

// @module("@tanstack/react-query")
// external useQueries: queriesOptions<'queryKey, 'queryData, 'queryError, 'pageParam> => array<
//   queryResult<'queryError, 'queryData>,
// > = "useQueries"
