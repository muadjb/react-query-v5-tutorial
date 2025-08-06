@react.component
let make = () => {
  let (commentText, setCommentText) = React.useState(_ => "")

  let commentTextIsEmpty = commentText->String.trim->String.length === 0

  let mutation = RescriptInfiniteComments_UseComments_Optimistic.useCreateCommentMutationOptimistic()

  React.useEffect(() => {
    Console.log2(`!!!!!commentText`, commentText)
    None
  }, [commentText])

  // let comments = data?.pages.flatMap((page) => page.comments);
  let handleSubmit = e => {
    e->ReactEvent.Form.preventDefault
    switch commentTextIsEmpty {
    | true => ()
    | false =>
      let mutationVariables: Comment.newComment = {
        text: commentText,
      }
      mutation.mutate(
        mutationVariables,
        Some({
          onSuccess: Some(
            (a, b, c) => {
              setCommentText(_ => "")
              // toast.success("Comment posted successfully!")
              Console.log(`Comment posted successfully!`)
              42->Promise.resolve
            },
          ),
          onError: Some(
            (a, b, c) => {
              Console.error(`Failed to post comment. Please try again.`)

              -1->Promise.resolve
            },
          ),
          onSettled: Some(
            (a, b, c, d) => {
              Console.log(`onSettled`)

              0->Promise.resolve
            },
          ),
        }),
      )
    }
  }

  <form onSubmit={handleSubmit} className="flex gap-2 mb-6">
    <Input
      value={commentText}
      type_="text"
      onChange={e => setCommentText(_ => ReactEvent.Form.target(e)["value"])}
      placeholder="Add a comment..."
      className="flex-1"
      // disabled={mutation.isPending}
      disabled=false
    />
    <button type_="submit" disabled={commentTextIsEmpty} className="px-4 py-2 bg-slate-500 text-white rounded-lg " >
      // {(mutation.isPending ? "Posting..." : "Post")->React.string}
      {"Post"->React.string}
    </button>
  </form>
}
