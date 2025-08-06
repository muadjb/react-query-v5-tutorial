import { fetchData, postData } from '@/lib/fetch-utils'
import {
  InfiniteData,
  QueryKey,
  useInfiniteQuery,
  useMutation,
  useQueryClient,
} from '@tanstack/react-query'
import { Comment } from '../api/comments/data'
import { CommentsResponse } from '../api/comments/route'
import { log } from 'console'

const queryKey: QueryKey = ['comments']

export function useCommentsQuery() {
  // const queryFn = (params: TQueryFnData) => {
  //   console.log('\\\\\\\\\\\\params', params)
  //   console.log('\\\\\\\\\\\\params.pageParam', params.pageParam)
  //   fetchData<CommentsResponse>(
  //     `/api/comments?${params.pageParam ? `cursor=${params.pageParam}` : ''}`
  //   )
  // }

  // declare function useInfiniteQuery<TQueryFnData, TError = DefaultError, TData = InfiniteData<TQueryFnData>, TQueryKey extends QueryKey = QueryKey, TPageParam = unknown>(options: DefinedInitialDataInfiniteOptions<TQueryFnData, TError, TData, TQueryKey, TPageParam>, queryClient?: QueryClient): DefinedUseInfiniteQueryResult<TData, TError>;
  // declare function useInfiniteQuery<TQueryFnData, TError = DefaultError, TData = InfiniteData<TQueryFnData>, TQueryKey extends QueryKey = QueryKey, TPageParam = unknown>(options: UndefinedInitialDataInfiniteOptions<TQueryFnData, TError, TData, TQueryKey, TPageParam>, queryClient?: QueryClient): UseInfiniteQueryResult<TData, TError>;
  // declare function useInfiniteQuery<TQueryFnData, TError = DefaultError, TData = InfiniteData<TQueryFnData>, TQueryKey extends QueryKey = QueryKey, TPageParam = unknown>(options: UseInfiniteQueryOptions<TQueryFnData, TError, TData, TQueryKey, TPageParam>, queryClient?: QueryClient): UseInfiniteQueryResult<TData, TError>;

  return useInfiniteQuery({
    queryKey,
    // queryFn: queryFn,
    queryFn: ({ pageParam }) => {
      console.log('\\\\\\\\\\\\pageParam', pageParam)
      return fetchData<CommentsResponse>(`/api/comments?${pageParam ? `cursor=${pageParam}` : ''}`)
    },
    initialPageParam: undefined as number | undefined,
    getNextPageParam: (lastPage) => {
      console.log('lastPage', lastPage)
      return lastPage.nextCursor
    },
  })
}

export function useCreateCommentMutation() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: (newComment: { text: string }) =>
      postData<{ comment: Comment }>('/api/comments', newComment),
    onSuccess: async ({ comment }) => {
      // Cancel any outgoing refetches to avoid them overwriting our optimistic update
      await queryClient.cancelQueries({ queryKey })

      // Update the query cache with the new comment so we don't have to wait for the refetch
      queryClient.setQueryData<InfiniteData<CommentsResponse, number | undefined>>(
        queryKey,
        (oldData) => {
          // Add the new comment to the first page of results
          const firstPage = oldData?.pages[0]

          if (firstPage) {
            return {
              ...oldData,
              pages: [
                {
                  ...firstPage,
                  totalComments: firstPage.totalComments + 1,
                  comments: [comment, ...firstPage.comments],
                },
                ...oldData.pages.slice(1),
              ],
            }
          }
        }
      )
    },

    // You can still invalidate the query afterwards but it's not really necessary
  })
}
