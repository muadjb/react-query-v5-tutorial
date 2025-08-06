type user = {
  name: string,
  avatar: string,
}

type t = {
  id: int,
  user: user,
  text: string,
  createdAt: string,
}

type newComment = {text: string}

let newCommentToJSON = (newComment: newComment) => {
  let dict = Dict.make()
  dict->Dict.set("text", newComment.text->JSON.Encode.string)
  dict->JSON.Encode.object
}

type returnData = {comment: t}
