// Minimal Vanilla JS for ReUse Hub

// Confirm delete dialog
function confirmDelete(id) {
    if (confirm("Are you sure you want to delete this item? This action cannot be undone.")) {
        document.getElementById('deleteForm_' + id).submit();
    }
}

// Toggle price field in Add/Edit Item forms
document.addEventListener("DOMContentLoaded", function() {
    const typeRadios = document.querySelectorAll('input[name="type"]');
    const priceGroup = document.getElementById('priceGroup');
    const priceInput = document.getElementById('priceInput');

    if (typeRadios.length > 0 && priceGroup) {
        // Init state
        typeRadios.forEach(radio => {
            if (radio.checked) {
                togglePriceGroup(radio.value);
            }
            
            // Listener
            radio.addEventListener('change', function() {
                togglePriceGroup(this.value);
            });
        });
    }

    function togglePriceGroup(type) {
        if (type === 'donate') {
            priceGroup.style.display = 'none';
            if (priceInput) priceInput.value = '0';
        } else {
            priceGroup.style.display = 'block';
        }
    }

    // Photo Preview Logic
    const photoInput = document.querySelector('input[name="photoUrl"]');
    const previewContainer = document.getElementById('photoPreviewContainer');
    const previewImage = document.getElementById('photoPreviewImage');

    if (photoInput && previewContainer && previewImage) {
        // Initial check if editing
        if (photoInput.value) {
            updatePreview(photoInput.value);
        }

        photoInput.addEventListener('input', function() {
            updatePreview(this.value);
        });
    }

    function updatePreview(url) {
        if (url && url.trim() !== '') {
            previewImage.src = url;
            previewContainer.style.display = 'block';
            
            // Handle error (bad URL)
            previewImage.onerror = () => {
                previewContainer.style.display = 'none';
            };
        } else {
            previewContainer.style.display = 'none';
        }
    }
});
