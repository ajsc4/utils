using Images

function getbrightframes(stack, meanvalues, threshold::Float64=(mean(meanvalues)+0.005))
    indices = findall(x -> x > threshold, meanvalues)
    return stack[:,:,indices]

end

newstack = getbrightframes(stack, meanvals)

save("newstack.tif", newstack)

    
