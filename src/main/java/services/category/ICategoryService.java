package services.category;

import models.Category;
import java.util.List;

public interface ICategoryService {
    List<Category> getAll();
    Category getById(int id);
    boolean add(Category category);
    boolean update(Category category);
    boolean delete(int id);
}
