module ApplicationHelper

  def truncate_to_sentences(text, sentence_count: 5)
      sentences = text.to_s.split(/(?<=\.)\s+/)  # Split text into sentences
      truncated = sentences.take(sentence_count).join(' ')  # Take first 5 sentences and join them
      truncated += '...' if sentences.size > sentence_count  # Append ellipsis if text was truncated
      truncated
    end
  
end
