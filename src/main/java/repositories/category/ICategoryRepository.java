package repositories.category;

import models.Category;
import java.util.List;

public interface ICategoryRepository {
    List<Category> findAll();
    Category findById(int id);
    boolean save(Category category);
    boolean update(Category category);
    boolean delete(int id);
}
