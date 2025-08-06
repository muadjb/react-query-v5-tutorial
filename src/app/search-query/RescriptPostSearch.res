type t = {
  id: int,
  title: string,
  body: string,
}

@module("../../lib/fetch-utils") external fetchData: string => Promise.t<array<t>> = "fetchData"
// @module("../../hooks/use-debounce.ts") external useDebounce: ('a, int) => 'a = "useDebounce"

@react.component
let make = () => {
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let debouncedSearchTerm = UseDebounce.use(searchTerm, 500)

  let {data, isLoading, isError, error, _} = RescriptQuery.useQuery({
    queryKey: ["posts", "search", debouncedSearchTerm],
    queryFn: _ => fetchData(`/api/posts/search?search=${debouncedSearchTerm}`),
    enabled: debouncedSearchTerm->String.length > 0,
  })

  React.useEffect(() => {
    Console.log2(`!!!!!searchTerm`, searchTerm)
    None
  }, [searchTerm])

  React.useEffect(() => {
    Console.log2(`!!!!!debouncedSearchTerm`, debouncedSearchTerm)
    None
  }, [debouncedSearchTerm])

  React.useEffect(() => {
    Console.log2(`!!!!!data`, data)
    None
  }, [data])

  <div className="space-y-4">
    <div className="flex gap-2">
      <Input
        type_="text"
        placeholder="Search posts..."
        value={searchTerm}
        onChange={e => setSearchTerm(_ => ReactEvent.Form.target(e)["value"])}
        className="w-full"
      />
      <button
        onClick={_ => setSearchTerm(_ => "")}
        className="bg-gray-200 p-2 rounded"
        disabled={searchTerm->String.length == 0}>
        {"Clear"->React.string}
      </button>
    </div>

    {switch (debouncedSearchTerm->String.length === 0, isLoading, isError, data) {
    | (true, _, _, _) =>
      <p className="p-4 text-center text-gray-500 border border-dashed rounded-md">
        {`Start typing to search...`->React.string}
      </p>
    | (false, true, _, _) =>
      <p className="mb-4 text-blue-500"> {`Loading posts...`->React.string} </p>
    | (false, false, true, _) =>
      Console.log2(`error`, error)
      <p className="mb-4 text-red-500"> {`Error: `->React.string} </p>
    | (false, false, false, Some(posts)) =>
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
