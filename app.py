import streamlit as st
from rembg import remove
from PIL import Image
import io

st.title("Background Remover")
st.write("Upload an image to remove its background.")

# File uploader
uploaded_file = st.file_uploader("Choose an image file", type=["jpg", "jpeg", "png"])

if uploaded_file is not None:
    # Display the uploaded image
    st.image(uploaded_file, caption="Uploaded Image", use_container_width=True)

    # Process the image
    with st.spinner("Processing..."):
        input_image = Image.open(uploaded_file)
        output_image = remove(input_image)

        # Save the processed image to a BytesIO object
        img_buffer = io.BytesIO()
        output_image.save(img_buffer, format="PNG")
        img_buffer.seek(0)  # Reset the pointer to the start of the buffer

    # Display the processed image
    st.image(output_image, caption="Processed Image", use_container_width=True)

    # Create a download button
    st.download_button(
        label="Download Processed Image",
        data=img_buffer,
        file_name="processed_image.png",
        mime="image/png"
    )