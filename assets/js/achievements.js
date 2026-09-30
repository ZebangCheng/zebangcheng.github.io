(() => {
  const dialog = document.getElementById("certificate-dialog");
  if (!dialog || typeof dialog.showModal !== "function") return;

  const title = document.getElementById("certificate-dialog-title");
  const image = document.getElementById("certificate-dialog-image");
  const pdf = document.getElementById("certificate-dialog-pdf");
  let trigger;

  document.querySelectorAll("[data-certificate-preview]").forEach((link) => {
    link.setAttribute("aria-haspopup", "dialog");
    link.addEventListener("click", (event) => {
      if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;

      event.preventDefault();
      trigger = link;
      title.textContent = link.dataset.certificateTitle;
      image.src = link.href;
      image.alt = link.querySelector("img").alt;
      pdf.href = link.dataset.certificatePdf;
      dialog.showModal();
      document.documentElement.classList.add("certificate-viewer-open");
    });
  });

  dialog.addEventListener("click", (event) => {
    if (event.target !== dialog) return;
    const bounds = dialog.getBoundingClientRect();
    const outside = event.clientX < bounds.left || event.clientX > bounds.right ||
      event.clientY < bounds.top || event.clientY > bounds.bottom;
    if (outside) dialog.close();
  });

  dialog.addEventListener("close", () => {
    document.documentElement.classList.remove("certificate-viewer-open");
    image.removeAttribute("src");
    if (trigger) trigger.focus({ preventScroll: true });
  });
})();
