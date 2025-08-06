@module("../../lib/fetch-utils")
external postData: (string, JSON.t) => Promise.t<array<Comment.t>> = "postData"

let queryKey = ["comments"]

let useCreateCommentMutationOptimistic = () => {
  let queryClient = RescriptQuery.Client.useQueryClient()

  RescriptQuery.Mutation.useMutation({
    mutationKey: ["my", "mutation"],
    mutationFn: (newComment: Comment.newComment) =>
      postData("/api/comments", newComment->Comment.newCommentToJSON),
    onMutate: async newCommentData => {
      // Cancel any outgoing refetches to avoid them overwriting our optimistic update
      await queryClient.cancelQueries(
        Some({
          RescriptQuery.Types.queryKey: Some(queryKey),
        }),
      )

      // Snapshot the previous value for rollback in case of error
      let previousData = queryClient.getQueryData(Some(queryKey))

      let optimisticComment: Comment.t = {
        id: Date.now()->Float.toInt,
        text: newCommentData.text,
        // In a real app, user data would come from your auth provider
        user: {
          name: "Current User",
          avatar: "CU",
        },
        createdAt: Date.make()->Date.toUTCString,
      }

      // Update the cache with our optimistic comment
      queryClient.setQueryData(Some(queryKey), None)
      // => {
      // let firstPage = oldData?.pages[0];
      // Console.log2(`maybeOldData`, maybeOldData)
      // let firstPage = maybeOldData->Option.mapOr(0, oldData => oldData.pages[0])

      // switch firstPage {
      // | None => Console.log(`===========firstpage is NONE`)
      // | Some(x) => {
      //     ...oldData,
      //     pages: [
      //       {
      //         ...firstPage,
      //         totalComments: firstPage.totalComments + 1,
      //         comments: [optimisticComment, ...firstPage.comments],
      //       },
      //       ...oldData.pages.slice(1),
      //     ],
      //   }
      // }

      // Return the previous data for the onError handler
      // Some(previousData)
      // })
    },
    onError: (error, variables, context) => {
      Console.log2(`onError context`, context)
      let valueToSet = switch context->Nullable.toOption {
      | None => None
      | Some(c) =>
        Console.log2(`context`, c)
        Some("none")
      }
      42->Promise.resolve
      // queryClient.setQueryData(Some(queryKey), valueToSet)
    },
  })
}
