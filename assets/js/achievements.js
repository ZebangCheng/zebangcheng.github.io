(() => {
  const dialog = document.getElementById("gallery-dialog");
  if (!dialog || typeof dialog.showModal !== "function") return;

  const title = document.getElementById("gallery-dialog-title");
  const image = document.getElementById("gallery-dialog-image");
  const caption = document.getElementById("gallery-caption");
  const counter = document.getElementById("gallery-counter");
  const original = document.getElementById("gallery-original");
  const previous = dialog.querySelector(".gallery-prev");
  const next = dialog.querySelector(".gallery-next");
  const stage = dialog.querySelector(".gallery-stage");
  const error = dialog.querySelector(".gallery-error");
  let items = [];
  let index = 0;
  let gallery;
  let trigger;
  let swipe;

  const show = (position) => {
    index = (position + items.length) % items.length;
    const item = items[index];
    error.hidden = true;
    image.alt = item.dataset.galleryAlt;
    image.src = item.href;
    caption.textContent = item.dataset.galleryCaption;
    counter.textContent = `${index + 1} / ${items.length}`;
    original.hidden = item.dataset.galleryPlaceholder === "true";
    original.href = gallery.dataset.galleryDocument || item.href;
    original.textContent = gallery.dataset.galleryDocument ? "Open original PDF ↗" : "Open full-size image ↗";
    previous.hidden = next.hidden = items.length < 2;
  };

  document.querySelectorAll("[data-gallery]").forEach((group) => {
    group.querySelectorAll("[data-gallery-open]").forEach((link) => {
      link.setAttribute("aria-haspopup", "dialog");
      link.addEventListener("click", (event) => {
        if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
        const slides = Array.from(group.querySelectorAll(".gallery-item"));
        if (!slides.length) return;
        event.preventDefault();
        items = slides;
        gallery = group;
        trigger = link;
        title.textContent = group.dataset.galleryTitle;
        show(Number(link.dataset.galleryOpen));
        dialog.showModal();
        document.documentElement.classList.add("gallery-viewer-open");
      });
    });
  });

  previous.addEventListener("click", () => show(index - 1));
  next.addEventListener("click", () => show(index + 1));
  dialog.addEventListener("keydown", (event) => {
    if (event.altKey || event.ctrlKey || event.metaKey || items.length < 2) return;
    if (event.key === "ArrowLeft" || event.key === "ArrowRight") {
      event.preventDefault();
      show(index + (event.key === "ArrowRight" ? 1 : -1));
    }
  });
  stage.addEventListener("pointerdown", (event) => {
    if (event.pointerType !== "touch" || event.target.closest("button")) return;
    swipe = { x: event.clientX, y: event.clientY };
  });
  stage.addEventListener("pointerup", (event) => {
    if (!swipe) return;
    const dx = event.clientX - swipe.x;
    const dy = event.clientY - swipe.y;
    swipe = null;
    if (items.length > 1 && Math.abs(dx) > 45 && Math.abs(dx) > Math.abs(dy) * 1.5) show(index + (dx < 0 ? 1 : -1));
  });
  stage.addEventListener("pointercancel", () => { swipe = null; });
  image.addEventListener("error", () => { if (dialog.open) error.hidden = false; });
  dialog.addEventListener("click", (event) => {
    if (event.target !== dialog) return;
    const bounds = dialog.getBoundingClientRect();
    if (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom) dialog.close();
  });
  dialog.addEventListener("close", () => {
    document.documentElement.classList.remove("gallery-viewer-open");
    image.removeAttribute("src");
    swipe = null;
    if (trigger) trigger.focus({ preventScroll: true });
  });
})();
