module ErrorRenderHelper
  def error_jsonapi(data)
    return {errors: [data.errors.full_messages]}
  end
end
