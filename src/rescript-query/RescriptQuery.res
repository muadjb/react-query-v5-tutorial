module TanstackQuery_Types = {
  type query
  type timeValue
  type boolOrAlwaysValue
  type refetchIntervalValue
  type notifyOnChangePropsValue
  type retryValue<'queryError>
  type retryDelayValue<'queryError>
  type queryDataKeyOrFilterValue<'queryKey>
  type placeholderDataValue

  type queryFunctionContext<'queryKey, 'pageParam> = {
    queryKey: 'queryKey,
    pageParam: 'pageParam,
  }

  type retryParam<'error> = [#bool(bool) | #number(int) | #fn((int, 'error) => bool)]
  type retryDelayParam<'error> = [#number(int) | #fn((int, 'error) => int)]
  type time = [#number(int) | #infinity]
  type refetchInterval = [#bool(bool) | #number(int)]
  type boolOrAlways = [#bool(bool) | #always]
  type notifyOnChangeProps = [#array(array<string>) | #all]

  type infiniteData<'queryData> = {
    pages: array<'queryData>,
    pageParams: array<int>,
  }

  type queryStatus = [#loading | #success | #error | #initialData]

  type placeholderData<'queryData, 'queryResult> = [
    | #data('queryData)
    | #function(unit => option<'queryResult>)
  ]

  type queryFilter<'queryKey> = {
    exact?: bool,
    @as("type") type_?: [#active | #inactive | #all],
    stale?: bool,
    fetching?: bool,
    predicate?: query => bool,
    queryKey?: 'queryKey,
  }

  type queryDataKeyOrFilter<'queryKey> = [#keys('queryKey) | #filters(queryFilter<'queryKey>)]

  type refetchOptions = {
    throwOnError: bool,
    cancelRefetch: bool,
  }
}

module TanstackQuery_Client = {
  type queryClientValue
  type fetchMeta

  type notifyOnChangePropsKeys = [
    | #error
    | #isError
    | #isIdle
    | #isLoading
    | #isLoadingError
    | #isRefetchError
    | #isSuccess
    | #status
    | #tracked
  ]

  type infiniteQueryObserverResultProps = [
    | #error
    | #isError
    | #isIdle
    | #isLoading
    | #isLoadingError
    | #isRefetchError
    | #isSuccess
    | #status
    | #tracked
  ]

  type fetchContext

  type queryBehavior = {onFetch: fetchContext => unit}

  type getPreviousPageParamFunction<'data> = {
    firstPage: 'data,
    allPages: array<'data>,
  }

  type getNextPageParamFunction<'data> = {
    lastPage: 'data,
    allPages: array<'data>,
  }

  type queryObserverOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam> = {
    retry?: TanstackQuery_Types.retryValue<'error>,
    retryDelay?: TanstackQuery_Types.retryValue<'error>,
    cacheTime?: int,
    isDataEqual?: (option<'data>, 'data) => bool,
    queryFn: TanstackQuery_Types.queryFunctionContext<'queryKey, 'pageParam> => Js.Promise.t<
      'queryData,
    >,
    queryHash?: string,
    queryKey?: 'queryKey,
    queryKeyHashFn?: 'queryKey => string,
    initialData?: unit => 'data,
    initialDataUpdatedAt?: unit => option<int>,
    behavior?: queryBehavior, // Revisar context type
    structuralSharing?: bool,
    getPreviousPageParam?: getPreviousPageParamFunction<'data>,
    getNextPageParam?: getNextPageParamFunction<'data>,
    _defaulted?: bool,
    enabled?: bool,
    staleTime?: int,
    refetchInterval?: TanstackQuery_Types.refetchIntervalValue,
    refetchIntervalInBackground?: bool,
    refetchOnWindowFocus?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnReconnect?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
    retryOnMount?: bool,
    notifyOnChangeProps?: array<notifyOnChangePropsKeys>,
    notifyOnChangePropsExclusions?: array<bool>,
    onSuccess?: 'data => unit,
    onError?: 'error => unit,
    onSettled?: (option<'data>, option<'error>) => unit,
    useErrorBoundary?: bool,
    select?: 'queryData => 'data,
    suspense?: bool,
    keepPreviousData?: bool,
    placeholderData?: TanstackQuery_Types.placeholderDataValue,
    optimisticResults?: bool,
  }

  type defaultOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam> = {
    queries: option<queryObserverOptions<'error, 'data, 'queryData, 'queryKey, 'pageParam>>,
  }

  type invalidateQueryFilter = {refetchType: [#active | #inactive | #all | #none]}

  type clientRefetchOptions = {throwOnError: option<bool>}

  type invalidateQueryOptions<'queryKey> = {
    queryKey: option<'queryKey>,
    filters: option<invalidateQueryFilter>,
    refetchOptions: option<clientRefetchOptions>,
  }

  type refetchQueriesOptions<'queryKey> = {
    queryKey: option<'queryKey>,
    filters: option<TanstackQuery_Types.queryFilter<'queryKey>>,
    refetchOptions: option<clientRefetchOptions>,
  }

  type cancelQueriesOptions<'queryKey> = {
    queryKey: option<'queryKey>,
    filters: option<TanstackQuery_Types.queryFilter<'queryKey>>,
  }

  type queryState<'queryData, 'queryError> = {
    data: option<'queryData>,
    dataUpdateCount: int,
    dataUpdatedAt: int,
    error: Js.Nullable.t<'queryError>,
    errorUpdateCount: int,
    errorUpdatedAt: int,
    fetchFailureCount: int,
    fetchMeta: fetchMeta,
    isFetching: bool,
    isInvalidated: bool,
    isPaused: bool,
    status: TanstackQuery_Types.queryStatus,
  }

  type fetchQueryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
    queryKey?: 'queryKey,
    queryFn?: TanstackQuery_Types.queryFunctionContext<'queryKey, 'pageParam> => Js.Promise.t<
      'queryData,
    >,
    retry?: TanstackQuery_Types.retryValue<'queryError>,
    retryOnMount?: bool,
    retryDelay?: TanstackQuery_Types.retryDelayValue<'queryError>,
    staleTime?: TanstackQuery_Types.timeValue,
    queryKeyHashFn?: 'queryKey => string,
    refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
    structuralSharing?: bool,
    initialData?: 'queryData => 'queryData,
    initialDataUpdatedAt?: unit => int,
  }

  type queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> = {
    fetchQuery: fetchQueryOptions<'queryKey, 'queryData, 'queryError, 'pageParams> => Js.Promise.t<
      'queryData,
    >,
    fetchInfiniteQuery: fetchQueryOptions<
      'queryKey,
      'queryData,
      'queryError,
      'pageParams,
    > => Js.Promise.t<TanstackQuery_Types.infiniteData<'queryData>>,
    prefetchQuery: fetchQueryOptions<
      'queryKey,
      'queryData,
      'queryError,
      'pageParams,
    > => Js.Promise.t<unit>,
    prefetchInfiniteQuery: fetchQueryOptions<
      'queryKey,
      'queryData,
      'queryError,
      'pageParams,
    > => Js.Promise.t<unit>,
    getQueryData: 'queryKey => option<'queryData>,
    setQueryData: ('queryKey, option<'queryData>) => 'queryData,
    getQueryState: (
      'queryKey,
      TanstackQuery_Types.queryFilter<'queryKey>,
    ) => queryState<'queryData, 'queryError>,
    setQueriesData: (
      TanstackQuery_Types.queryDataKeyOrFilterValue<'queryKey>,
      option<'queryData> => 'queryData,
    ) => unit,
    invalidateQueries: (
      option<TanstackQuery_Types.queryFilter<'queryKey>>,
      option<clientRefetchOptions>,
    ) => Js.Promise.t<unit>,
    refetchQueries: (
      option<TanstackQuery_Types.queryFilter<'queryKey>>,
      option<clientRefetchOptions>,
    ) => Js.Promise.t<unit>,
    cancelQueries: option<TanstackQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
    removeQueries: option<TanstackQuery_Types.queryFilter<'queryKey>> => Js.Promise.t<unit>,
    resetQueries: (
      option<TanstackQuery_Types.queryFilter<'queryKey>>,
      option<clientRefetchOptions>,
    ) => Js.Promise.t<unit>,
    isFetching: option<TanstackQuery_Types.queryFilter<'queryKey>> => bool,
    isMutating: option<TanstackQuery_Types.queryFilter<'queryKey>> => bool,
    // setDefaultOptions
    // getDefaultOptions
    // setQueryDefaults
    // getQueryDefaults
    // getQueryCache
    // setQueryCache
    // getMutationCache
    // setMutationCache
    clear: unit => unit,
  }

  @module("@tanstack/react-query")
  external useQueryClient: unit => queryClient<'queryKey, 'queryData, 'queryError, 'pageParams> =
    "useQueryClient"

  @new @module("@tanstack/react-query")
  external createClient: unit => queryClientValue = "QueryClient"

  module Provider = {
    @module("@tanstack/react-query") @react.component
    external make: (
      ~client: queryClientValue,
      ~contextSharing: bool=?,
      ~children: React.element,
    ) => React.element = "QueryClientProvider"
  }
}

module TanstackQuery_Hooks = {
  type resetErrorBoundary = {reset: unit => unit}

  @module("@tanstack/react-query")
  external useIsFetching: unit => bool = "useIsFetching"

  @module("@tanstack/react-query")
  external useIsFetchingWithKeys: 'queryKey => bool = "useIsFetching"

  @module("@tanstack/react-query")
  external useIsMutating: unit => bool = "useIsMutating"

  @module("@tanstack/react-query")
  external useIsMutatingWithKeys: 'queryKey => bool = "useIsMutating"

  @module("@tanstack/react-query")
  external useQueryErrorResetBoundary: unit => resetErrorBoundary = "useQueryErrorResetBoundary"
}

module TanstackQuery_InfiniteQuery = {
  type inifiniteQueryFunctionContext<'queryKey> = {
    queryKey: 'queryKey,
    pageParam: option<int>,
  }

  type infiniteQueryOptions<'queryKey, 'queryData, 'queryError> = {
    queryKey?: 'queryKey,
    queryFn?: inifiniteQueryFunctionContext<'queryKey> => Js.Promise.t<'queryData>,
    enabled?: bool,
    retry?: TanstackQuery_Types.retryValue<'queryError>,
    retryOnMount?: bool,
    retryDelay?: TanstackQuery_Types.retryDelayValue<'queryError>,
    staleTime?: TanstackQuery_Types.timeValue,
    queryKeyHashFn?: 'queryKey => string,
    refetchInterval?: TanstackQuery_Types.refetchIntervalValue,
    refetchIntervalInBackground?: bool,
    refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnWindowFocus?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnReconnect?: TanstackQuery_Types.boolOrAlwaysValue,
    notifyOnChangeProps?: TanstackQuery_Types.notifyOnChangePropsValue,
    notifyOnChangePropsExclusions?: array<string>,
    onSuccess?: 'queryData => unit,
    onError?: 'queryError => unit,
    onSettled?: ('queryData, 'queryError) => unit,
    select?: 'queryData => 'queryData,
    suspense?: bool,
    keepPreviousData?: bool,
    structuralSharing?: bool,
    useErrorBoundary?: bool,
    initialData?: 'queryData => 'queryData,
    initialDataUpdatedAt?: unit => int,
    placeholderData?: unit => 'queryData,
    getNextPageParam?: 'queryData => option<int>,
    getPreviousPageParam?: 'queryData => option<int>,
  }

  type rec infiniteQueryResult<'queryError, 'queryData> = {
    status: TanstackQuery_Types.queryStatus,
    isIdle: bool,
    isError: bool,
    isFetched: bool,
    isFetchedAfterMount: bool,
    isFetching: bool,
    isLoading: bool,
    isLoadingError: bool,
    isPlaceholderData: bool,
    isPreviousData: bool,
    isRefetchError: bool,
    isStale: bool,
    isSuccess: bool,
    dataUpdatedAt: int,
    error: Js.Nullable.t<'queryError>,
    errorUpdatedAt: int,
    failureCount: int,
    refetch: TanstackQuery_Types.refetchOptions => Js.Promise.t<
      infiniteQueryResult<'queryError, 'queryData>,
    >,
    remove: unit => unit,
    data: option<TanstackQuery_Types.infiniteData<'queryData>>,
    isFetchingNextPage: bool,
    isFetchingPreviousPage: bool,
    fetchNextPage: unit => unit,
    //fetchPreviousPage: (options?: FetchPreviousPageOptions) => Promise<UseInfiniteQueryResult>
    hasNextPage: bool,
    hasPreviousPage: bool,
  }

  @module("@tanstack/react-query")
  external useInfiniteQuery: infiniteQueryOptions<
    'queryKey,
    'queryData,
    'queryError,
  > => infiniteQueryResult<'queryError, 'queryData> = "useInfiniteQuery"
}

module TanstackQuery_Mutation = {
  type mutationContext

  type mutationStatus = [#loading | #success | #error]

  type mutateParams<'mutationVariables, 'mutationData, 'mutationError, 'unknown> = {
    onSuccess: option<
      ('mutationData, 'mutationVariables, Js.Nullable.t<mutationContext>) => Js.Promise.t<'unknown>,
    >,
    onError: option<
      (
        'mutationError,
        'mutationVariables,
        Js.Nullable.t<mutationContext>,
      ) => Js.Promise.t<'unknown>,
    >,
    onSettled: option<
      (
        'mutationData,
        'mutationError,
        'mutationVariables,
        Js.Nullable.t<mutationContext>,
      ) => Js.Promise.t<'unknown>,
    >,
  }

  type mutationOptions<'mutationVariables, 'mutationData, 'mutationError, 'unknown> = {
    mutationKey: array<string>,
    mutationFn: 'mutationVariables => Js.Promise.t<'mutationData>,
    onMutate?: 'mutationVariables => Js.Promise.t<mutationContext>,
    onSuccess?: (
      'mutationData,
      'mutationVariables,
      Js.Nullable.t<mutationContext>,
    ) => Js.Promise.t<'unknown>,
    onError?: (
      'mutationError,
      'mutationVariables,
      Js.Nullable.t<mutationContext>,
    ) => Js.Promise.t<'unknown>,
    onSettled?: (
      'mutationData,
      'mutationError,
      'mutationVariables,
      Js.Nullable.t<mutationContext>,
    ) => Js.Promise.t<'unknown>,
    retry?: TanstackQuery_Types.retryValue<'mutationError>,
    retryDelay?: TanstackQuery_Types.retryDelayValue<'mutationError>,
    useErrorBoundary?: bool,
  }

  type mutationResult<'mutationVariables, 'mutationData, 'mutationError, 'unknown> = {
    mutate: (
      'mutationVariables,
      option<mutateParams<'mutationVariables, 'mutationData, 'mutationError, 'unknown>>,
    ) => unit,
    mutateAsync: (
      'mutationVariables,
      mutateParams<'mutationVariables, 'mutationData, 'mutationError, 'unknown>,
    ) => Js.Promise.t<'mutationData>,
    status: mutationStatus,
    isIdle: bool,
    isError: bool,
    isLoading: bool,
    isSuccess: bool,
    data: option<'mutationData>,
    error: Js.Nullable.t<'mutationError>,
    reset: unit => unit,
  }

  @module("@tanstack/react-query")
  external useMutation: mutationOptions<
    'mutationVariables,
    'mutationData,
    'mutationError,
    'unknown,
  > => mutationResult<'mutationVariables, 'mutationData, 'mutationError, 'unknown> = "useMutation"
}

module TanstackQuery_Query = {
  type queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
    queryKey?: array<'queryKey>,
    queryFn?: TanstackQuery_Types.queryFunctionContext<
      array<'queryKey>,
      'pageParam,
    > => Js.Promise.t<'queryData>,
    enabled?: bool,
    retry?: TanstackQuery_Types.retryValue<'queryError>,
    retryOnMount?: bool,
    retryDelay?: TanstackQuery_Types.retryDelayValue<'queryError>,
    staleTime?: TanstackQuery_Types.timeValue,
    queryKeyHashFn?: array<'queryKey> => string,
    refetchInterval?: TanstackQuery_Types.refetchIntervalValue,
    refetchIntervalInBackground?: bool,
    refetchOnMount?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnWindowFocus?: TanstackQuery_Types.boolOrAlwaysValue,
    refetchOnReconnect?: TanstackQuery_Types.boolOrAlwaysValue,
    notifyOnChangeProps?: TanstackQuery_Types.notifyOnChangePropsValue,
    notifyOnChangePropsExclusions?: array<string>,
    onSuccess?: 'queryData => unit,
    onError?: 'queryError => unit,
    onSettled?: ('queryData, 'queryError) => unit,
    select?: 'queryData => 'queryData,
    suspense?: bool,
    keepPreviousData?: bool,
    structuralSharing?: bool,
    useErrorBoundary?: bool,
    initialData?: 'queryData => 'queryData,
    initialDataUpdatedAt?: unit => int,
    placeholderData?: unit => 'queryData,
  }

  type rec queryResult<'queryError, 'queryData> = {
    status: TanstackQuery_Types.queryStatus,
    isIdle: bool,
    isError: bool,
    isFetched: bool,
    isFetchedAfterMount: bool,
    isFetching: bool,
    isLoading: bool,
    isLoadingError: bool,
    isPlaceholderData: bool,
    isPreviousData: bool,
    isRefetchError: bool,
    isStale: bool,
    isSuccess: bool,
    data: option<'queryData>,
    dataUpdatedAt: int,
    error: Js.Nullable.t<'queryError>,
    errorUpdatedAt: int,
    failureCount: int,
    refetch: TanstackQuery_Types.refetchOptions => Js.Promise.t<
      queryResult<'queryError, 'queryData>,
    >,
    remove: unit => unit,
  }

  @module("@tanstack/react-query")
  external useQuery: queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam> => queryResult<
    'queryError,
    'queryData,
  > = "useQuery"

  type queriesOptions<'queryKey, 'queryData, 'queryError, 'pageParam> = {
    queries: array<queryOptions<'queryKey, 'queryData, 'queryError, 'pageParam>>,
  }

  @module("@tanstack/react-query")
  external useQueries: queriesOptions<'queryKey, 'queryData, 'queryError, 'pageParam> => array<
    queryResult<'queryError, 'queryData>,
  > = "useQueries"
}

module TanstackQuery_Utils = {
  let retry: TanstackQuery_Types.retryParam<'error> => TanstackQuery_Types.retryValue<
    'error,
  > = value =>
    switch value {
    | #bool(value) => Obj.magic(value)
    | #number(value) => Obj.magic(value)
    | #fn(value) => Obj.magic(value)
    }

  let retryDelay: TanstackQuery_Types.retryDelayParam<
    'error,
  > => TanstackQuery_Types.retryDelayValue<'error> = value =>
    switch value {
    | #number(value) => Obj.magic(value)
    | #fn(value) => Obj.magic(value)
    }

  let time: TanstackQuery_Types.time => TanstackQuery_Types.timeValue = value =>
    switch value {
    | #number(value) => Obj.magic(value)
    | #infinity => Obj.magic(infinity)
    }

  let refetchInterval = value =>
    switch value {
    | #bool(value) => Obj.magic(value)
    | #number(value) => Obj.magic(value)
    }

  let boolOrAlways = value =>
    switch value {
    | #bool(value) => Obj.magic(value)
    | #always => Obj.magic(#always)
    }

  let notifyOnChangeProps = value =>
    switch value {
    | #array(value) => Obj.magic(value)
    | #tracked => Obj.magic(#tracked)
    }

  let setQueryData: TanstackQuery_Types.queryDataKeyOrFilter<
    'queryKey,
  > => TanstackQuery_Types.queryDataKeyOrFilter<'queryKey> = value =>
    switch value {
    | #keys(value) => Obj.magic(value)
    | #filters(value) => Obj.magic(value)
    }

  let placeholderData: TanstackQuery_Types.placeholderData<
    'queryData,
    'queryResult,
  > => TanstackQuery_Types.placeholderDataValue = value =>
    switch value {
    | #data(data) => Obj.magic(data)
    | #function(value) => Obj.magic(value)
    }

  let refetchOnMount = boolOrAlways
  let refetchOnWindowFocus = boolOrAlways
  let refetchOnReconnect = boolOrAlways
}

// include TanstackQuery
include TanstackQuery_Query

module Client = TanstackQuery_Client
module Hooks = TanstackQuery_Hooks
module InfiniteQuery = TanstackQuery_InfiniteQuery
module Mutation = TanstackQuery_Mutation
module Query = TanstackQuery_Query
module Types = TanstackQuery_Types
module Utils = TanstackQuery_Utils

module DevTools = {
  @react.component @module("@tanstack/react-query-devtools")
  external make: (~initialIsOpen: bool=?) => React.element = "TanstackQueryDevtools"
}
