@react.component
let make = () => {
  let {
    data,
    isLoading,
    isError,
    error,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
    _,
  } = RescriptInfiniteComments_UseComments.useCommentsQuery()

  // let comments = data?.pages.flatMap((page) => page.comments);
  let comments = switch data {
  | None =>
    Console.log(`~~~~ data is NONE`)
    []
  | Some(response) =>
    Console.log2(`response pageParams`, response.pageParams)
    Console.log2(`response pages`, response.pages)
    // response.pages->Array.map(page => {page.comments})
    response.pages->Array.flatMap(page => page.comments)
  }

  <div className="">
    <h2 className="text-xl font-bold mb-4"> {"Comments "->React.string} </h2>

    <RescriptInfiniteComments_Form />

    {switch (isLoading, isError, comments->Array.length == 0) {
    | (true, true, _) => <p className="mb-4 text-blue-500"> {`Loading posts...`->React.string} </p>
    | (false, true, _) =>
      Console.log2(`error`, error)
      <p className="mb-4 text-red-500"> {`Error Loading comments: `->React.string} </p>
    | (false, false, true) =>
      <p className="mb-4 bg-blue-50"> {"No comments yet."->React.string} </p>

    | _ =>
      <div>
        <div className="space-y-3">
          {comments
          ->Array.map(comment =>
            <div
              key={comment.id->Int.toString} className="flex gap-3 p-3 border rounded-lg bg-white">
              <div className="flex-shrink-0">
                <div
                  className="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center text-sm font-medium">
                  {comment.user.avatar->React.string}
                </div>
              </div>
              <div className="flex-1">
                <div className="flex justify-between items-start">
                  <p className="font-medium"> {comment.user.name->React.string} </p>
                  <span className="text-xs text-gray-500"> {comment.createdAt->React.string} </span>
                </div>
                <p className="text-gray-700 mt-1"> {comment.text->React.string} </p>
              </div>
            </div>
          )
          ->React.array}
        </div>

        <div className="flex justify-center my-4">
          {switch hasNextPage {
          | false => React.null
          | true =>
            <button
              onClick={_ => fetchNextPage()}
              disabled={isFetchingNextPage}
              className="px-4 py-2 bg-gray-600 text-white rounded-lg ">
              {(isFetchingNextPage ? "Loading more..." : "Load More Comments")->React.string}
            </button>
          }}
        </div>
      </div>
    }}
  </div>
}
