@module("../../lib/fetch-utils")
external fetchData: string => Promise.t<RescriptInfiniteComments_UseComments_Response.t> =
  "fetchData"

let queryKey = ["comments"]

let useCommentsQuery = () => {
  let queryFn = (
    params: RescriptQuery.InfiniteQuery.inifiniteQueryFunctionContext<array<string>>,
  ) => {
    Console.log2(`___________params`, params)
    Console.log2(`________pageParam`, params.pageParam)

    let cursorArgument = switch params.pageParam {
    | None => ""
    | Some(pageNumber) => `cursor=${pageNumber->Int.toString}`
    }

    Console.log2(`cursorArgument`, cursorArgument)

    fetchData(`/api/comments?${cursorArgument}`)
  }

  RescriptQuery.InfiniteQuery.useInfiniteQuery({
    queryKey,
    queryFn,
    initialPageParam: 0,
    getNextPageParam: lastPage => lastPage.nextCursor,
  })
}
