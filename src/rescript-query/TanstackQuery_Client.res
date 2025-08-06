// type queryClientValue
// type fetchMeta

// type notifyOnChangePropsKeys = [
//   | #error
//   | #isError
//   | #isIdle
//   | #isLoading
//   | #isLoadingError
//   | #isRefetchError
//   | #isSuccess
//   | #status
//   | #tracked
// ]

// type infiniteQueryObserverResultProps = [
//   | #error
//   | #isError
//   | #isIdle
//   | #isLoading
//   | #isLoadingError
//   | #isRefetchError
//   | #isSuccess
//   | #status
//   | #tracked
// ]

// type fetchContext

// type queryBehavior = {onFetch: fetchContext => unit}

// type getPreviousPageParamFunction<'data> = {
//   firstPage: 'data,
//   allPages: array<'data>,
// }

// type getNextPageParamFunction<'data> = {
//   lastPage: 'data,
//   allPages: array<'data>,
// }

// type queryObserverOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam> = {
//   retry?: TanstackQuery_Types.retryValue<'error>,
//   retryDelay?: TanstackQuery_Types.retryValue<'error>,
//   cacheTime?: int,
//   isDataEqual?: (option<'data>, 'data) => bool,
//   queryFn: TanstackQuery_Types.queryFunctionContext<'queryKey, 'pageParam> => Js.Promise.t<
//     'queryData,
//   >,
//   queryHash?: string,
//   queryKey?: 'queryKey,
//   queryKeyHashFn?: 'queryKey => string,
//   initialData?: unit => 'data,
//   initialDataUpdatedAt?: unit => option<int>,
//   behavior?: queryBehavior, // Revisar context type
//   structuralSharing?: bool,
//   getPreviousPageParam?: getPreviousPageParamFunction<'data>,
//   getNextPageParam?: getNextPageParamFunction<'data>,
//   _defaulted?: bool,
//   enabled?: bool,
//   staleTime?: int,
//   refetchInterval?: TanstackQuery_Types.refetchIntervalValue,
//   refetchIntervalInBackground?: bool,
//   refetchOnWindowFocus?: TanstackQuery_Types.boolOrAlwaysValue,
//   refetchOnReconnect?: TanstackQuery_Types.boolOrAlwaysValue,
//   refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
//   retryOnMount?: bool,
//   notifyOnChangeProps?: array<notifyOnChangePropsKeys>,
//   notifyOnChangePropsExclusions?: array<bool>,
//   onSuccess?: 'data => unit,
//   onError?: 'error => unit,
//   onSettled?: (option<'data>, option<'error>) => unit,
//   useErrorBoundary?: bool,
//   select?: 'queryData => 'data,
//   suspense?: bool,
//   keepPreviousData?: bool,
//   placeholderData?: TanstackQuery_Types.placeholderDataValue,
//   optimisticResults?: bool,
// }

// type defaultOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam> = {
//   queries: option<queryObserverOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam>>,
// }

// type invalidateQueryFilter = {refetchType: [#active | #inactive | #all | #none]}

// type clientRefetchOptions = {throwOnError: option<bool>}

// type invalidateQueryOptions<'queryKey> = {
//   queryKey: option<'queryKey>,
//   filters: option<invalidateQueryFilter>,
//   refetchOptions: option<clientRefetchOptions>,
// }

// type refetchQueriesOptions<'queryKey> = {
//   queryKey: option<'queryKey>,
//   filters: option<TanstackQuery_Types.queryFilter<'queryKey>>,
//   refetchOptions: option<clientRefetchOptions>,
// }

// type cancelQueriesOptions<'queryKey> = {
//   queryKey: option<'queryKey>,
//   filters: option<TanstackQuery_Types.queryFilter<'queryKey>>,
// }

// type queryState<'queryData, 'queryError> = {
//   data: option<'queryData>,
//   dataUpdateCount: int,
//   dataUpdatedAt: int,
//   error: Js.Nullable.t<'queryError>,
//   errorUpdateCount: int,
//   errorUpdatedAt: int,
//   fetchFailureCount: int,
//   fetchMeta: fetchMeta,
//   isFetching: bool,
//   isInvalidated: bool,
//   isPaused: bool,
//   status: TanstackQuery_Types.queryStatus,
// }

// type fetchQueryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
//   queryKey?: 'queryKey,
//   queryFn?: TanstackQuery_Types.queryFunctionContext<'queryKey, 'pageParam> => Js.Promise.t<
//     'queryData,
//   >,
//   retry?: TanstackQuery_Types.retryValue<'queryError>,
//   retryOnMount?: bool,
//   retryDelay?: TanstackQuery_Types.retryDelayValue<'queryError>,
//   staleTime?: TanstackQuery_Types.timeValue,
//   queryKeyHashFn?: 'queryKey => string,
//   refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
//   structuralSharing?: bool,
//   initialData?: 'queryData => 'queryData,
//   initialDataUpdatedAt?: unit => int,
// }

// type queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> = {
//   fetchQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError, 'pageParams> => Js.Promise.t<
//     'queryData,
//   >,
//   fetchInfiniteQuery: fetchQueryOptions<
//     'queryKey,
//     'queryData,
//     'queryError,
//     'pageParams,
//   > => Js.Promise.t<TanstackQuery_Types.infiniteData<'queryData>>,
//   prefetchQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError, 'pageParams> => Js.Promise.t<
//     unit,
//   >,
//   prefetchInfiniteQuery: fetchQueryOptions<
//     'queryKey,
//     'queryData,
//     'queryError,
//     'pageParams,
//   > => Js.Promise.t<unit>,
//   getQueryData: 'queryKey => option<'queryData>,
//   setQueryData: ('queryKey, option<'queryData>) => 'queryData,
//   getQueryState: (
//     'queryKey,
//     TanstackQuery_Types.queryFilter<'queryKey>,
//   ) => queryState<'queryData, 'queryError>,
//   setQueriesData: (
//     TanstackQuery_Types.queryDataKeyOrFilterValue<'queryKey>,
//     option<'queryData> => 'queryData,
//   ) => unit,
//   invalidateQueries: (
//     option<TanstackQuery_Types.queryFilter<'queryKey>>,
//     option<clientRefetchOptions>,
//   ) => Js.Promise.t<unit>,
//   refetchQueries: (
//     option<TanstackQuery_Types.queryFilter<'queryKey>>,
//     option<clientRefetchOptions>,
//   ) => Js.Promise.t<unit>,
//   cancelQueries: option<TanstackQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
//   removeQueries: option<TanstackQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
//   resetQueries: (
//     option<TanstackQuery_Types.queryFilter<'queryKey>>,
//     option<clientRefetchOptions>,
//   ) => Js.Promise.t<unit>,
//   isFetching: option<TanstackQuery_Types.queryFilter<'queryKey>> => bool,
//   isMutating: option<TanstackQuery_Types.queryFilter<'queryKey>> => bool,
//   // setDefaultOptions
//   // getDefaultOptions
//   // setQueryDefaults
//   // getQueryDefaults
//   // getQueryCache
//   // setQueryCache
//   // getMutationCache
//   // setMutationCache
//   clear: unit => unit,
// }

// @module("@tanstack/react-query")
// external useQueryClient: unit => queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> =
//   "useQueryClient"

// @new @module("@tanstack/react-query")
// external createClient: unit => queryClientValue = "QueryClient"

// module Provider = {
//   @module("@tanstack/react-query") @react.component
//   external make: (
//     ~client: queryClientValue,
//     ~contextSharing: bool=?,
//     ~children: React.element,
//   ) => React.element = "QueryClientProvider"
// }
