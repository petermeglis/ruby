def bubble_sort(arr)
  return arr if arr.length == 1

  sorted_arr = arr.clone
  is_sorted = false
  finished_index = sorted_arr.length

  until is_sorted do
    is_sorted = true
    i = 1
    while i < finished_index do
      if sorted_arr[i - 1] > sorted_arr[i]
        sorted_arr[i - 1], sorted_arr[i] = sorted_arr[i], sorted_arr[i - 1]
        is_sorted = false
      end
      i += 1
    end
    finished_index -= 1
  end
  sorted_arr
end

p bubble_sort([4])