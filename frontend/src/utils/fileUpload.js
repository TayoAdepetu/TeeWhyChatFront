export default async function uploadToIPFS(selectedFile) {
  try {
    const formData = new FormData();

    formData.append("file", selectedFile);

    const metadata = JSON.stringify({
      name: selectedFile.name,
    });
    formData.append("pinataMetadata", metadata);

    const options = JSON.stringify({
      cidVersion: 0,
    });
    formData.append("pinataOptions", options);

    const res = await fetch("https://api.pinata.cloud/pinning/pinFileToIPFS", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${import.meta.env.VITE_PINATA_JWT}`,
      },
      body: formData,
    });
    if (res.status !== 200) {
      throw new Error(res.statusText);
    }

    const resData = await res.json();
    console.log(resData);
    return resData;
  } catch (error) {
    throw new Error("Upload to IPFS failed: " + error.message);
  }
}
