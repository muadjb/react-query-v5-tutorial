type t = {
  id: int,
  title: string,
  body: string,
}
// import { fetchData } from "@/lib/fetch-utils";
@module("../../lib/fetch-utils") external fetchData: string => Promise.t<array<t>> = "fetchData"

@react.component
let make = (~category) => {
  let {data, isLoading, isError, error, _} = RescriptQuery.useQuery({
    queryKey: ["posts", category],
    queryFn: _ => fetchData(`/api/posts?category=${category}`),
    // refetchOnWindowFocus: RescriptQuery.Query.refetchOnWindowFocus(#bool(false)),
    refetchOnWindowFocus: RescriptQuery.Utils.refetchOnWindowFocus(#bool(true)),
  })

  Console.log2(`data`, data)

  <div className="p-4">
    <h2 className="text-xl font-bold mb-4"> {`${category} Posts`->React.string} </h2>

    {switch (isLoading, isError, data) {
    | (true, _, _) => <p className="mb-4 text-blue-500"> {`Loading posts...`->React.string} </p>
    | (false, true, _) =>
      Console.log2(`error`, error)
      <p className="mb-4 text-red-500"> {`Error: `->React.string} </p>
    | (false, false, Some(posts)) =>
      switch posts->Array.length == 0 {
      | true => <p className="mb-4 "> {`No posts found`->React.string} </p>
      | false =>
        <ul className="space-y-4">
          {posts
          ->Array.map(post => {
            <li key={post.id->Int.toString} className="border p-3 rounded">
              <h3 className="font-semibold"> {post.title->React.string} </h3>
              <p> {post.body->React.string} </p>
            </li>
          })
          ->React.array}
        </ul>
      }

    | _ => <p className="mb-4 bg-red-100"> {`Something went wrong`->React.string} </p>
    }}

    // {switch isLoading {
    // | false => React.null
    // | true =>
    // }}

    // {switch isError {
    // | false => React.null
    // | true =>

    // }}

    // {switch data {
    // | None => <p className="mb-4 text-red-500"> {`Data is None`->React.string} </p>
    // | Some(posts) =>

    // //  <p className="mb-4 bg-yellow-100"> {json->JSON.stringify->React.string} </p>
    // }}

    // {posts &&
    // posts.length > 0 &&
  </div>
}
